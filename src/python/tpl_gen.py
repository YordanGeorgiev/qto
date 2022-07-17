#!/usr/bin/env python3
# purpose: a quick and dirty semi-generic template generator, based on dir naming convention and
# shallow data structure ...
# usage: src/python/tpl_gen.py

import sys
import os
import os.path as path
import json
import glob
from jinja2 import Environment, BaseLoader
from pprintjson import pprintjson as ppjson
import pprint

product_instance_dir, json_cnf_fle, cnf, pp, version = '', '', '', '', ''

def main():
    set_vars()
    do_generate(cnf)
    sys.exit(0)

def set_vars():
    try:
        global product_instance_dir, json_cnf_fle, cnf, pp, cnf, version
        pp = pprint.PrettyPrinter(indent=3)
        product_instance_dir = path.abspath(path.join(__file__ ,"../../.."))
        do_read_conf_fle(product_instance_dir + '/.env') # env agnostic
        env = os.environ['ENV']
        version = os.environ['VERSION']

        with open(product_instance_dir + '/cnf/env/' + env + '.env.json') as json_cnf_fle:
            cnf = json.load(json_cnf_fle)
            cnf['env']['VERSION'] = version
            cnf['env']['VER'] = version.replace('.','')
        ppjson ( cnf )

    except(IndexError) as error:
        print ("ERROR in set_vars: " , str(error)) 
        traceback.print_stack()
        sys.exit(1)


def do_read_conf_fle(f):
    try:
        with open(f, 'r') as fh:
            vars_dict = dict(
                tuple(line.rstrip().split('='))
                for line in fh.readlines() if not line.startswith('#')
            )
        os.environ.update(vars_dict)
    except (Exception) as error:
        print('ERROR in do_read_conf_fle:' , error)
        traceback.print_stack()
    finally:
        print("RUNNING in the following env: " , vars_dict)


def do_generate(cnf):
    for f in glob.iglob( product_instance_dir + '/src/tpl/**/*.tpl', recursive=True):
        try:
            print ( "read template file: " , f)
            pp.pprint (cnf)
            str_tpl = open(f, 'r').read()
            obj_tpl = Environment(loader=BaseLoader).from_string(str_tpl)
            rendered = obj_tpl.render(cnf['env'])
            print(cnf)
            pp.pprint ( rendered )
            tgt_fle = f.replace('/src/tpl','',1).replace('.tpl','')
            # print (rendered)
            print(rendered,  file=open(tgt_fle, 'w'))
            print ( "output ready rendered file : " , tgt_fle)
        except Exception as e:
            print ("RENDERING EXCEPTION: \n", str(e))
            traceback.print_stack()
    print("STOP generating templates")


main()
