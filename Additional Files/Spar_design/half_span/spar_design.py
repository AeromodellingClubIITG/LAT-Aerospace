import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

FOS = 2.0

R_TF_TW = 2.0
R_BF_H  = 0.30


def make_span_positions(b_half, N_input):
    if N_input <= 10:
        return np.linspace(0.0, b_half, N_input + 1)
    else:
        return np.linspace(0.0, b_half, N_input)


def tapered_lift_distribution(y, b_half, L_half, c_root, c_tip):
    c_y = c_root + (c_tip - c_root) * (y / b_half)
    shape = c_y

    try:
        L_current = np.trapezoid(shape, y)
    except AttributeError:
        L_current = np.trapz(shape, y)

    scale = L_half / L_current
    return scale * shape


def compute_sfd_bmd(y, w):
    dy = y[1] - y[0]
    n = len(y)
    V = np.zeros(n)
    M = np.zeros(n)

    for i in range(n - 2, -1, -1):
        V[i] = V[i + 1] + w[i + 1] * dy
    for i in range(n - 2, -1, -1):
        M[i] = M[i + 1] + V[i + 1] * dy

    return V, M


def plot_sfd_bmd(y, V, M, folder, suffix=""):
    folder = Path(folder)
    folder.mkdir(exist_ok=True)

    n = len(y)
    ms = 3 if n <= 15 else 2

    plt.figure(figsize=(7, 4))
    plt.axhline(0, linewidth=0.8)
    plt.plot(y, V / 1000.0, "-o", markersize=ms, linewidth=1.2)
    plt.xlabel("y [m]")
    plt.ylabel("V [kN]")
    plt.xlim(0.0, y[-1])
    plt.grid(True, linestyle=":")
    plt.tight_layout()
    plt.savefig(folder / f"SFD{suffix}.png", dpi=300)
    plt.close()

    plt.figure(figsize=(7, 4))
    plt.axhline(0, linewidth=0.8)
    plt.plot(y, M / 1000.0, "-o", markersize=ms, linewidth=1.2)
    plt.xlabel("y [m]")
    plt.ylabel("M [kN·m]")
    plt.xlim(0.0, y[-1])
    plt.grid(True, linestyle=":")
    plt.tight_layout()
    plt.savefig(folder / f"BMD{suffix}.png", dpi=300)
    plt.close()


def save_shear_moment_to_files(y, V, M, folder):
    folder = Path(folder)
    folder.mkdir(exist_ok=True)

    with open(folder / "shear_distribution.txt", "w") as f:
        f.write("# y [m]\tV(y) [N]\n")
        for yi, Vi in zip(y, V):
            f.write(f"{yi:.6f}\t{Vi:.3f}\n")

    with open(folder / "moment_distribution.txt", "w") as f:
        f.write("# y [m]\tM(y) [N·m]\n")
        for yi, Mi in zip(y, M):
            f.write(f"{yi:.6f}\t{Mi:.3f}\n")


def i_beam_geometry(t_web, h_total):
    t_flange = R_TF_TW * t_web
    h_web = h_total - 2.0 * t_flange
    if h_web <= 0.0:
        return None

    b_flange = R_BF_H * h_total

    A_flange = b_flange * t_flange
    A_web = t_web * h_web
    A_total = 2.0 * A_flange + A_web

    I_web_centroid = (t_web * h_web**3) / 12.0
    I_flange_centroid = (b_flange * t_flange**3) / 12.0

    c = h_total / 2.0
    y_flange_centroid = c - t_flange / 2.0
    d = y_flange_centroid

    I_flange_total = 2.0 * (I_flange_centroid + A_flange * d**2)
    I_total = I_flange_total + I_web_centroid

    return {
        "t_web": t_web,
        "t_flange": t_flange,
        "h_web": h_web,
        "b_flange": b_flange,
        "A": A_total,
        "I": I_total
    }


def check_constraints(geom, M_per, V_per, E, sigma_allow, tau_allow,
                      b_half, delta_allow):
    t_web = geom["t_web"]
    h_total = geom["h_web"] + 2.0 * geom["t_flange"]
    h_web = geom["h_web"]
    I = geom["I"]
    c = h_total / 2.0

    sigma = M_per * c / I
    tau_avg = V_per / (t_web * h_web)
    delta_tip = M_per * b_half**2 / (2.0 * E * I)

    if sigma > sigma_allow:
        return False
    if tau_avg > tau_allow:
        return False
    if delta_tip > delta_allow:
        return False
    return True


def spar_volume(geom, b_half):
    return geom["A"] * b_half


def search_design(b_half, M_per, V_per, E, sigma_allow, tau_allow,
                  delta_allow, rho,
                  h_min, h_max,
                  n_h=120, n_t=80,
                  out_folder="."):

    out_folder = Path(out_folder)
    out_folder.mkdir(exist_ok=True)

    h_values = np.linspace(h_min, h_max, n_h)
    feasible_points = []

    best_geom = None
    best_vol = None
    min_feasible_height = None

    for h_total in h_values:
        t_min = max(0.0005, h_total / 400.0)
        t_max = h_total / (2.0 * R_TF_TW + 1e-9) * 0.9
        if t_max <= t_min:
            continue

        t_values = np.linspace(t_min, t_max, n_t)

        best_geom_this_h = None
        best_vol_this_h = None
        any_feasible_this_h = False

        for t_web in t_values:
            geom = i_beam_geometry(t_web, h_total)
            if geom is None:
                continue

            if not check_constraints(geom, M_per, V_per, E,
                                     sigma_allow, tau_allow,
                                     b_half, delta_allow):
                continue

            any_feasible_this_h = True
            feasible_points.append((t_web, h_total))

            V_spar = spar_volume(geom, b_half)
            if best_vol_this_h is None or V_spar < best_vol_this_h:
                best_vol_this_h = V_spar
                best_geom_this_h = geom

        if any_feasible_this_h:
            min_feasible_height = h_total
            best_geom = best_geom_this_h
            best_vol = best_vol_this_h
            break

    feasible_points = np.array(feasible_points) if feasible_points else np.empty((0, 2))

    if best_geom is None:
        return None, None, None, None, feasible_points

    best_mass = rho * best_vol
    return best_geom, best_vol, best_mass, min_feasible_height, feasible_points


def save_feasible_region(feasible_points, h_min, h_max, out_folder="."):
    out_folder = Path(out_folder)
    out_folder.mkdir(exist_ok=True)

    if feasible_points.size == 0:
        print("[info] no feasible points")
        return

    out_csv = out_folder / "feasible_xy_points.csv"
    np.savetxt(out_csv, feasible_points,
               delimiter=",", header="t_web[horiz],h_overall[vert]",
               comments="")
    print("feasible points ->", out_csv)

    out_png = out_folder / "feasible_region.png"
    plt.figure(figsize=(6, 5))
    plt.scatter(feasible_points[:, 0], feasible_points[:, 1], s=5)
    plt.xlabel("t_web [m]")
    plt.ylabel("h_overall [m]")
    plt.grid(True, linestyle=":")
    plt.tight_layout()
    plt.savefig(out_png, dpi=300)
    plt.close()
    print("feasible region plot ->", out_png)


def save_design_summary_for_spar(best_geom, best_vol, best_mass,
                                 b_half, M_per, V_per,
                                 E, sigma_allow, tau_allow,
                                 delta_allow, min_feasible_height,
                                 out_folder=".",
                                 spar_index=None):
    out_folder = Path(out_folder)
    out_folder.mkdir(exist_ok=True)

    if spar_index is None:
        fname = "spar_design_summary.txt"
    else:
        fname = f"spar_{spar_index}_design_summary.txt"

    out_txt = out_folder / fname

    t_web = best_geom["t_web"]
    t_flange = best_geom["t_flange"]
    h_web = best_geom["h_web"]
    h_total = h_web + 2.0 * t_flange
    b_flange = best_geom["b_flange"]
    I = best_geom["I"]
    A = best_geom["A"]

    c = h_total / 2.0
    sigma = M_per * c / I
    tau_avg = V_per / (t_web * h_web)
    delta_tip = M_per * b_half**2 / (2.0 * E * I)

    with open(out_txt, "w") as f:
        f.write("Wing Spar I-beam Design (per spar)\n")
        f.write("=================================\n\n")
        f.write("Inputs (for this spar):\n")
        f.write(f"  Half-span b/2          = {b_half:.6e} m\n")
        f.write(f"  M_root                 = {M_per:.6e} N·m\n")
        f.write(f"  V_root                 = {V_per:.6e} N\n")
        f.write(f"  E                      = {E:.6e} Pa\n")
        f.write(f"  sigma_allow            = {sigma_allow:.6e} Pa\n")
        f.write(f"  tau_allow              = {tau_allow:.6e} Pa\n")
        f.write(f"  delta_allow            = {delta_allow:.6e} m\n\n")

        f.write("Optimal I-beam section at minimum feasible height:\n")
        f.write(f"  h_overall              = {h_total:.6e} m\n")
        f.write(f"  t_web                  = {t_web:.6e} m\n")
        f.write(f"  t_flange               = {t_flange:.6e} m\n")
        f.write(f"  h_web                  = {h_web:.6e} m\n")
        f.write(f"  b_flange               = {b_flange:.6e} m\n")
        f.write(f"  Area A                 = {A:.6e} m^2\n")
        f.write(f"  Second moment I        = {I:.6e} m^4\n\n")

        f.write("Volume & mass (one spar, half-span):\n")
        f.write(f"  Volume V_half          = {best_vol:.6e} m^3\n")
        f.write(f"  Mass m_half            = {best_mass:.6e} kg\n\n")

        if min_feasible_height is not None:
            f.write("Minimum overall height that passed all checks:\n")
            f.write(f"  h_min_feasible         = {min_feasible_height:.6e} m\n\n")
        else:
            f.write("No feasible height found in the given range.\n\n")

        f.write("Check at optimal section:\n")
        f.write(f"  sigma (bending)        = {sigma:.6e} Pa\n")
        f.write(f"  tau_avg (web shear)    = {tau_avg:.6e} Pa\n")
        f.write(f"  delta_tip              = {delta_tip:.6e} m\n\n")
        f.write("Safety margins (allowable / actual):\n")
        f.write(f"  Bending                = {sigma_allow / sigma:.3f}\n")
        f.write(f"  Shear                  = {tau_allow / tau_avg:.3f}\n")
        f.write(f"  Deflection             = {delta_allow / delta_tip:.3f}\n")

    print("spar summary ->", out_txt)


def save_overall_summary(V_root_total, M_root_total,
                         n_spars, shares,
                         per_spar_results,
                         out_folder="."):
    out_folder = Path(out_folder)
    out_folder.mkdir(exist_ok=True)
    out_txt = out_folder / "all_spars_summary.txt"

    total_volume_half = sum(r["best_vol"] for r in per_spar_results)
    total_mass_half = sum(r["best_mass"] for r in per_spar_results)
    total_volume_full = 2.0 * total_volume_half
    total_mass_full = 2.0 * total_mass_half

    with open(out_txt, "w") as f:
        f.write("All Spars Combined Summary\n")
        f.write("==========================\n\n")
        f.write("Root loads (this half-wing, all spars):\n")
        f.write(f"  |V_root_total|         = {V_root_total:.6e} N\n")
        f.write(f"  |M_root_total|         = {M_root_total:.6e} N·m\n\n")

        f.write(f"Number of spars          = {n_spars}\n")
        f.write("User load share fractions:\n")
        for i, s in enumerate(shares, start=1):
            f.write(f"  Spar {i}: {s:.6f}\n")
        f.write("\n")

        for i, r in enumerate(per_spar_results, start=1):
            f.write(f"--- Spar {i} ---\n")
            f.write(f"  Fraction               = {shares[i-1]:.6f}\n")
            f.write(f"  M_root (this spar)     = {r['M_per']:.6e} N·m\n")
            f.write(f"  V_root (this spar)     = {r['V_per']:.6e} N\n")
            f.write(f"  h_min_feasible         = {r['min_h']:.6e} m\n")
            f.write(f"  Volume (half-span)     = {r['best_vol']:.6e} m^3\n")
            f.write(f"  Mass (half-span)       = {r['best_mass']:.6e} kg\n\n")

        f.write("All spars together, ONE wing (half-span each):\n")
        f.write(f"  Total volume_half      = {total_volume_half:.6e} m^3\n")
        f.write(f"  Total mass_half        = {total_mass_half:.6e} kg\n\n")

        f.write("All spars together, BOTH wings:\n")
        f.write(f"  Total volume_full      = {total_volume_full:.6e} m^3\n")
        f.write(f"  Total mass_full        = {total_mass_full:.6e} kg\n")

    print("all-spars summary ->", out_txt)


def main():
    print("wing spar sizing\n")

    b_half = float(input("b/2 [m]: "))
    c_root = float(input("c_root [m]: "))
    c_tip = float(input("c_tip [m]: "))
    n_load = float(input("load factor n: "))
    W_aircraft = float(input("W_aircraft [N]: "))
    W_wing = float(input("W_wing_total [N]: "))
    W_fuel = float(input("W_fuel [N]: "))
    N_input = int(input("N span stations: "))

    y = make_span_positions(b_half, N_input)

    L_total = n_load * W_aircraft
    L_half = L_total / 2.0

    w_lift = tapered_lift_distribution(y, b_half, L_half, c_root, c_tip)

    W_half = 0.5 * (W_wing + W_fuel)
    w_weight = (W_half / b_half) * np.ones_like(y)

    w_net = w_lift - w_weight

    V, M = compute_sfd_bmd(y, w_net)

    plot_sfd_bmd(y, V, M, ".")
    save_shear_moment_to_files(y, V, M, ".")

    V_root_total = abs(V[0])
    M_root_total = abs(M[0])

    print("root loads (half wing):")
    print("  V_root:", V_root_total, "N")
    print("  M_root:", M_root_total, "N·m")

    E = float(input("\nE [Pa]: "))
    sigma_y = float(input("sigma_y [Pa]: "))
    tau_y = float(input("tau_y [Pa]: "))
    n_spars = int(input("number of spars: "))
    delta_allow = float(input("delta_allow [m]: "))
    rho = float(input("rho [kg/m^3]: "))

    sigma_allow = sigma_y / FOS
    tau_allow = tau_y / FOS

    print("\nload share fractions (sum ~ 1):")
    shares = []
    for i in range(n_spars):
        s_i = float(input(f"  spar {i+1}: "))
        shares.append(s_i)

    shares = np.array(shares, dtype=float)
    sum_shares = shares.sum()
    if sum_shares <= 0.0:
        raise ValueError("invalid shares")
    if abs(sum_shares - 1.0) > 1e-6:
        shares = shares / sum_shares

    V_per_list = shares * V_root_total
    M_per_list = shares * M_root_total

    print("\nper-spar loads:")
    for i in range(n_spars):
        print(f"  spar {i+1}: V={V_per_list[i]:.3f} N, M={M_per_list[i]:.3f} N·m")

    print("\nheight range:")
    h_min = float(input("  h_min [m]: "))
    h_max = float(input("  h_max [m]: "))

    if h_max <= h_min:
        h_max = h_min

    per_spar_results = []

    for i in range(n_spars):
        print(f"\n designing spar {i+1}")
        spar_folder = f"spar_{i+1}"

        best_geom, best_vol, best_mass, min_feasible_height, feasible_points = search_design(
            b_half=b_half,
            M_per=M_per_list[i],
            V_per=V_per_list[i],
            E=E,
            sigma_allow=sigma_allow,
            tau_allow=tau_allow,
            delta_allow=delta_allow,
            rho=rho,
            h_min=h_min,
            h_max=h_max,
            n_h=120,
            n_t=80,
            out_folder=spar_folder
        )

        if best_geom is None:
            print("  no feasible design for this spar in given h range")
            save_feasible_region(feasible_points, h_min, h_max, spar_folder)
            return

        save_feasible_region(feasible_points, h_min, h_max, spar_folder)
        save_design_summary_for_spar(
            best_geom, best_vol, best_mass,
            b_half, M_per_list[i], V_per_list[i],
            E, sigma_allow, tau_allow,
            delta_allow, min_feasible_height,
            out_folder=spar_folder,
            spar_index=i+1
        )

        per_spar_results.append({
            "M_per": M_per_list[i],
            "V_per": V_per_list[i],
            "best_vol": best_vol,
            "best_mass": best_mass,
            "min_h": min_feasible_height,
            "geom": best_geom
        })

        t_web = best_geom["t_web"]
        t_flange = best_geom["t_flange"]
        h_web = best_geom["h_web"]
        h_total = h_web + 2.0 * t_flange
        b_flange = best_geom["b_flange"]

        print("  h:", h_total, "m, t_web:", t_web, "m, b_flange:", b_flange, "m")
        print("  V_half:", best_vol, "m^3, m_half:", best_mass, "kg")

    save_overall_summary(
        V_root_total, M_root_total,
        n_spars, shares,
        per_spar_results,
        out_folder="."
    )

    total_volume_half = sum(r["best_vol"] for r in per_spar_results)
    total_mass_half = sum(r["best_mass"] for r in per_spar_results)
    total_volume_full = 2.0 * total_volume_half
    total_mass_full = 2.0 * total_mass_half

    print("\nall spars totals:")
    print("  volume one wing:", total_volume_half, "m^3")
    print("  mass   one wing:", total_mass_half, "kg")
    print("  volume both wings:", total_volume_full, "m^3")
    print("  mass   both wings:", total_mass_full, "kg")


if __name__ == "__main__":
    main()