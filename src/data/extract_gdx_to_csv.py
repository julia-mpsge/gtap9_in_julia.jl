import gams.transfer as gt
import os

import argparse

def open_gdx_file(gdx_file_path):
    """Open a GDX file and return the GDX object."""
    gdx = gt.Container(gdx_file_path)
    return gdx


def extract_sets(gdx, output_dir = "data/sets"):
    """Extract sets from the GDX file and save them as CSV files."""
    os.makedirs(output_dir, exist_ok=True)
    for set in gdx.getSets():
        df = set.records
        name = set.name
        df.to_csv(f"{output_dir}/{name}.csv", index=False)


def extract_parameters(gdx, output_dir = "data/sets"):
    """Extract sets from the GDX file and save them as CSV files."""
    os.makedirs(output_dir, exist_ok=True)
    for set in gdx.getParameters():
        df = set.records
        name = set.name
        df.to_csv(f"{output_dir}/{name}.csv", index=False)


def main():


    parser = argparse.ArgumentParser(description="Extract GDX file to CSV files.")
    parser.add_argument("gdx_file", type=str, help="Path to the GDX file.")
    parser.add_argument("--output_dir", type=str, default="data", help="Output directory for set CSV files.")
    parser.add_argument("--set_dir", type=str, default="sets", help="Output directory for set CSV files.")
    parser.add_argument("--param_dir", type=str, default="params", help="Output directory for parameter CSV files.")
    args = parser.parse_args()

    gdx = open_gdx_file(args.gdx_file)
    set_dir = os.path.join(args.output_dir, args.set_dir)
    extract_sets(gdx, output_dir = set_dir)
    param_dir = os.path.join(args.output_dir, args.param_dir)
    extract_parameters(gdx, output_dir = param_dir)


if __name__ == "__main__":

    main()