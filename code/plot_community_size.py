#!/usr/bin/python

import os

try: 
    input = raw_input
except NameError: 
    pass

rootPath = "";
while not os.path.exists(rootPath):
    rootPath = input("Enter your Root Path: ")

import re
import matplotlib.pyplot as plt
import math
    
def plot_community_size(folder):
    nodes = []
    for i in range(0, 4):
        nodes.append({})
        filename = folder + '/connection' + str(i+1) + '.txt_files_0.0_w_0.0/cliques'
    
        with open(filename, 'rb') as fh:
            for line in fh:
                #line = line.replace('\n', '')
                line = re.sub("[\n\r]", '', line)
        
                # line = re.sub('(?:^\s*)|(?:\s*$)', '', line)
                line = re.sub('^\s*|\s*$', '', line)
        
                #if re.match('(?:^#)|(?:^\s*$)', line):
                if re.match('^#|^\s*$', line):
                    continue
        
                elements = re.split(':', line)
                if len(elements) != 2:
                    continue
        
                elements[1] = re.sub('^\s*|\s*$', '', elements[1])
                members = re.split('\s+', elements[1])
                member_size = len(members)
                if nodes[i].has_key(member_size):
                    nodes[i][member_size] += 1
                else:
                    nodes[i][member_size] = 1
    
    ### custom sort
    ##def comparator(x, y):
    ##    return int(x)-int(y)
    ##
    ##for k in sorted(nodes.keys(), comparator):
    ##    print(k, nodes[k])
    #
    #for k, v in nodes.iteritems():
    #    print k, v
    
    def dot_type(x):
        return {
            0: 'o',
            1: 'x',
            2: 's',
            3: '+'
        }[x]
    
    plt.figure(1)
    plt.axis([0, 1, 0, 4.5])
    plt.xlabel("Community Size (log10)")
    plt.ylabel("Average number of communities (log10)")
    for i in range(0, 4):
        for k, v in nodes[i].iteritems():
            plt.plot(math.log(k, 10), math.log(v, 10), dot_type(i))
    plt.show()
    
folder = ["1000", "1100", "2000", "5000", "9000"]
for i in folder:
    plot_community_size(rootPath + '/' + i)

