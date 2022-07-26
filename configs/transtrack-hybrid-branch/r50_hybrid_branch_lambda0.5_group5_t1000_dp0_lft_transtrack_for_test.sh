#!/usr/bin/env bash

# Training
python3 -m torch.distributed.launch --nproc_per_node=8 --use_env main_track.py \
--output_dir outputs/transtrack-hybrid-branch/r50_hybrid_branch_lambda0.5_group5_t1000_dp0_lft_transtrack_for_val \
--dataset_file mix \
--coco_path mix \
--batch_size 2 \
--with_box_refine \
--resume pretrain/crowdhuman_hybrid_branch.pth \
--epochs 20 \
--lr_drop 10 \
--track_train_split trainall \
--dim_feedforward 2048 \
--num_queries_one2one 500 \
--num_queries_one2many 1000 \
--k_one2many 5 \
--lambda_one2many 0.5 \
--dropout 0.0 \
--look_forward_twice

# Inference
python3 -m torch.distributed.launch --nproc_per_node=8 --use_env main_track.py  \
--dataset_file mot \
--coco_path mot \
--batch_size 1 \
--resume outputs/transtrack-hybrid-branch/r50_hybrid_branch_lambda0.5_group5_t1000_dp0_lft_transtrack_for_val/checkpoint.pth \
--eval \
--with_box_refine \
--num_queries_one2one 500 \
--dim_feedforward 2048 \
--track_eval_split test \
--dist_video \
--output_dir outputs/transtrack-hybrid-branch/r50_hybrid_branch_lambda0.5_group5_t1000_dp0_lft_transtrack_for_val \
--track_thresh 0.3