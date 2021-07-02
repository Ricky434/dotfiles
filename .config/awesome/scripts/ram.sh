#!/bin/bash
free --mega | awk '/^Mem/ { print $3"M" }' | sed s/i//g
