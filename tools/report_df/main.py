import sys
import json
import jinja2
from Metric import Metric
import MatplotlibPlotter
from BenchmarkData import BenchmarkData
import DataProcessing
from ReportGeneration import generate_report
import argparse
import logging

def parse_args():
    parser = argparse.ArgumentParser(description=(
        "Creates detailed plots from experiment summary and generates a report "
        "for the Magma website."
    ))
    parser.add_argument("json",
        help="The experiment summary JSON file generated by the benchd tool.")
    parser.add_argument("outdir",
        help="The path to the directory where webpage output and hierarchy "
             "will be stored.")
    parser.add_argument('-v', '--verbose', action='count', default=0,
        help=("Controls the verbosity of messages. "
            "-v prints info. -vv prints debug. Default: warnings and higher.")
        )
    return parser.parse_args()

def configure_verbosity(level):
    mapping = {
        0: logging.WARNING,
        1: logging.INFO,
        2: logging.DEBUG
    }
    # will raise exception when level is invalid
    numeric_level = mapping[level]
    logging.basicConfig(level=numeric_level)

def main():
    args = parse_args()
    configure_verbosity(args.verbose)
    bd = BenchmarkData(args.json, config={'duration': 24 * 60 * 60, 'trials': 10})
    generate_report(bd, args.outdir)

if __name__ == '__main__':
    main()
