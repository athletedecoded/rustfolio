# Image Classification with TF

**Project Repo:** [https://github.com/athletedecoded/rust-mlops](https://github.com/athletedecoded/rust-mlops/tree/main/tf-rust)

Adapting the [Tensorflow Rust example](https://github.com/tensorflow/rust/tree/master/examples), use the Tensorflow crate and Rust bindings to classifiy images with MobileNetv3.

## Useage

**Load image dataset**

Upload your images to tf-rust/img


**Load model and preprocess images**

Note this will print python based model predictions to CLI

```
pip3 install -r requirements.txt
python3 preprocess.py
```

**Run inference**

Assumes `<img_name>.png` exists in folder ./models/inputs after `running preprocess.py`
```
cargo run image --name <img_name>
```