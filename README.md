# H-TransTrack

## Modified files

### To support hybrid branch

* models/deformable_detrtrack_train_hybrid_branch.py

* models/deformable_transformer_track_hybrid_branch.py

* engine_track.py

* main_track.py

## MODEL ZOO
### MOT17 Validation
Model | MOTA% | IDF1% | FN | Checkpoint |
:---:|:---:|:---:|:---:|:---:|
TransTrack | 67.1 | 70.3 | 15820 | [model](https://github.com/HDETR/H-TransTrack/releases/download/v1.0.0/671mot17_crowdhuman_mot17.pth)| 
H-TransTrack | 68.7 | 68.3 | 13657 | [model](https://github.com/HDETR/H-TransTrack/releases/download/v1.0.0/690htranstrack_val.pth)|

### MOT17 Test
Model | MOTA% | IDF1% | FN |
:---:|:---:|:---:|:---:|
TransTrack | 74.5 | 63.9| 112137 |
H-TransTrack | 75.7 | 64.4 | 91155 |

#### Requirements
- Linux, CUDA>=9.2, GCC>=5.4
- Python>=3.7
- PyTorch ≥ 1.5 and [torchvision](https://github.com/pytorch/vision/) that matches the PyTorch installation.
  You can install them together at [pytorch.org](https://pytorch.org) to make sure of this
- OpenCV is optional and needed by demo and visualization

2. Prepare datasets and annotations
```
mkdir crowdhuman
cp -r /path_to_crowdhuman_dataset/CrowdHuman_train crowdhuman/CrowdHuman_train
cp -r /path_to_crowdhuman_dataset/CrowdHuman_val crowdhuman/CrowdHuman_val
mkdir mot
cp -r /path_to_mot_dataset/train mot/train
cp -r /path_to_mot_dataset/test mot/test
```
CrowdHuman dataset is available in [CrowdHuman](https://www.crowdhuman.org/). 
```
python3 track_tools/convert_crowdhuman_to_coco.py
```
MOT dataset is available in [MOT](https://motchallenge.net/).
```
python3 track_tools/convert_mot_to_coco.py
```

3. Pre-train on crowdhuman

sh configs/<path_to_config_file>.sh

4. Train H-TransTrack

sh configs/<path_to_config_file>.sh

5. Evaluate TransTrack

sh configs/<path_to_config_file>.sh

6. Visualize TransTrack
```
python3 track_tools/txt2video.py
```

## Citation
```bibtex
@article{jia2022detrs,
  title={DETRs with Hybrid Matching},
  author={Jia, Ding and Yuan, Yuhui and He, Haodi and Wu, Xiaopei and Yu, Haojun and Lin, Weihong and Sun, Lei and Zhang, Chao and Hu, Han},
  journal={arXiv preprint arXiv:2207.13080},
  year={2022}
}
```
