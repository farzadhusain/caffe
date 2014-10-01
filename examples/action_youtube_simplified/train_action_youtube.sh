#!/usr/bin/env sh

TOOLS=../../build/tools

$TOOLS/caffe train --solver=action_youtube_solver.prototxt
