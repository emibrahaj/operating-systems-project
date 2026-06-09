from __future__ import annotations

import csv
from pathlib import Path


def plot_metric_from_csv(csv_path: str | Path, x_col: str, y_col: str, out_path: str | Path, title: str) -> bool:
    rows = _read_points(csv_path, x_col, y_col)
    if not rows:
        return False

    try:
        import matplotlib.pyplot as plt
    except Exception:
        return _write_svg_plot(rows, x_col, y_col, out_path, title)

    out = Path(out_path)
    out.parent.mkdir(parents=True, exist_ok=True)
    xs = [point[0] for point in rows]
    ys = [point[1] for point in rows]
    plt.figure(figsize=(8, 5))
    plt.plot(xs, ys, marker="o")
    plt.title(title)
    plt.xlabel(x_col)
    plt.ylabel(y_col)
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig(out)
    plt.close()
    return True


def _read_points(csv_path: str | Path, x_col: str, y_col: str) -> list[tuple[float, float]]:
    points: list[tuple[float, float]] = []
    with Path(csv_path).open(newline="", encoding="utf-8") as fh:
        reader = csv.DictReader(fh)
        for row in reader:
            try:
                points.append((float(row[x_col]), float(row[y_col])))
            except (KeyError, ValueError):
                continue
    return points


def _write_svg_plot(points: list[tuple[float, float]], x_col: str, y_col: str, out_path: str | Path, title: str) -> bool:
    out = Path(out_path).with_suffix(".svg")
    out.parent.mkdir(parents=True, exist_ok=True)

    width = 800
    height = 500
    margin = 60
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    min_x, max_x = min(xs), max(xs)
    min_y, max_y = min(ys), max(ys)
    if max_x == min_x:
        max_x += 1
    if max_y == min_y:
        max_y += 1

    def sx(value: float) -> float:
        return margin + (value - min_x) / (max_x - min_x) * (width - 2 * margin)

    def sy(value: float) -> float:
        return height - margin - (value - min_y) / (max_y - min_y) * (height - 2 * margin)

    polyline = " ".join(f"{sx(x):.1f},{sy(y):.1f}" for x, y in points)
    circles = "\n".join(f'<circle cx="{sx(x):.1f}" cy="{sy(y):.1f}" r="4" fill="#2563eb" />' for x, y in points)
    svg = f"""<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}">
  <rect width="100%" height="100%" fill="white"/>
  <text x="{width / 2}" y="28" text-anchor="middle" font-family="Arial" font-size="18">{title}</text>
  <line x1="{margin}" y1="{height - margin}" x2="{width - margin}" y2="{height - margin}" stroke="black"/>
  <line x1="{margin}" y1="{margin}" x2="{margin}" y2="{height - margin}" stroke="black"/>
  <text x="{width / 2}" y="{height - 15}" text-anchor="middle" font-family="Arial" font-size="13">{x_col}</text>
  <text x="18" y="{height / 2}" text-anchor="middle" font-family="Arial" font-size="13" transform="rotate(-90 18 {height / 2})">{y_col}</text>
  <polyline points="{polyline}" fill="none" stroke="#2563eb" stroke-width="2"/>
  {circles}
</svg>
"""
    out.write_text(svg, encoding="utf-8")
    return True
