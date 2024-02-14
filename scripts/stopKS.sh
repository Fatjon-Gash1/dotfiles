#!/bin/bash

pid=$(pgrep -f "./buckle")

kill $pid
