#!/usr/bin/env sh
#args for EXTRACT_FEATURE
TOOL=../../../build/tools
MODEL=../../../examples/action_youtube_simplified/youtube_action_iter_10000.caffemodel #下载得到的caffe model
PROTOTXT=../../../examples/action_youtube_simplified/visualization/lenet_train_test.prototxt # 网络定义
LAYER=conv1 # 提取层的名字，如提取fc7等
LEVELDB=../../../examples/action_youtube_simplified/visualization/features_conv1 # 保存的leveldb路径
BATCHSIZE=10

# args for LEVELDB to MAT
DIM=91200 # 需要手工计算feature长度
OUT=../../../examples/action_youtube_simplified/visualization/features.mat #.mat文件保存路径
BATCHNUM=1 # 有多少哥batch， 本例只有两张图， 所以只有一个batch

$TOOL/extract_features.bin  $MODEL $PROTOTXT $LAYER $LEVELDB $BATCHSIZE CPU
python ../../../matlab/caffe/leveldb2mat.py $LEVELDB $BATCHNUM $BATCHSIZE $DIM $OUT 
