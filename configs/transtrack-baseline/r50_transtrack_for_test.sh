#!/usr/bin/env bash

# Training
python3 -m torch.distributed.launch --nproc_per_node=8 --master_port=23333 --use_env main_track.py \
--output_dir outputs/transtrack-hybrid-branch/r50_transtrack_for_test \
--dataset_file mix \
--coco_path mix \
--batch_size 2 \
--with_box_refine \
--resume pretrain/crowdhuman_final.pth \
--epochs 20 \
--lr_drop 10 \
--track_train_split trainall \
--num_queries_one2one 500 \
--num_queries_one2many 0 \
--k_one2many 0

# Inference
python3 -m torch.distributed.launch --nproc_per_node=8 --use_env main_track.py  \
--dataset_file mot \
--coco_path mot \
--batch_size 1 \
--resume outputs/transtrack-hybrid-branch/r50_transtrack_for_test/checkpoint.pth \
--eval \
--with_box_refine \
--num_queries_one2one 500 \
--track_eval_split test \
--dist_video \
--output_dir outputs/transtrack-hybrid-branch/r50_transtrack_for_test \
--track_thresh 0.3
