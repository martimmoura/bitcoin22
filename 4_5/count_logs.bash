#!/bin/bash

awk '{print $2}' | sort | uniq -c | sort -rn | awk '{print $1, $2}'