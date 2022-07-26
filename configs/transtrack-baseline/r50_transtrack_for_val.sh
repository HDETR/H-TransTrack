#!/usr/bin/env bash

# Training
python3 -m torch.distributed.launch --nproc_per_node=8 --master_port=23333 --use_env main_track.py \
--output_dir outputs/transtrack-baseline/r50_deformable_detr_for_val \
--dataset_file mot \
--coco_path mot \
--batch_size 2 \
--with_box_refine \
--resume pretrain/crowdhuman_final.pth \
--epochs 20 \
--lr_drop 10 \
--track_train_split train \
--num_queries_one2one 500 \
--num_queries_one2many 0 \
--k_one2many 0

# Inference
python3 -m torch.distributed.launch --nproc_per_node=8 --use_env main_track.py  \
--dataset_file mot \
--coco_path mot \
--batch_size 1 \
--resume outputs/transtrack-baseline/r50_deformable_detr_for_val/checkpoint.pth \
--eval \
--with_box_refine \
--num_queries_one2one 500 \
--track_eval_split val \
--dist_video \
--output_dir outputs/transtrack-baseline/r50_deformable_detr_for_val \
--track_thresh 0.3

# Eval MOT
python3 track_tools/eval_motchallenge.py \
--groundtruths mot/train \
--tests outputs/transtrack-baseline/r50_deformable_detr_for_val/val/tracks \
--gt_type _val_half \
--eval_official \
--score_threshold -1
