# Spoken Digit Recognition Using LPC Coefficients and the K-Nearest Neighbors Algorithm

## Overview

This project focuses on recognizing spoken digits (1, 2, 3) by leveraging Linear Predictive Coding (LPC) coefficients for feature extraction and employing the K-Nearest Neighbors (KNN) algorithm for classification. The entire system is implemented in **MATLAB**.

## Dataset

A custom dataset of spoken digits was created specifically for this project. While the dataset itself is not included in this repository, the MATLAB code used to generate a new dataset is provided, allowing users to create their own datasets for training and testing purposes.

## Methodology

1. **Preprocessing**: Audio signals undergo normalization and noise reduction to enhance quality and ensure consistency across samples.

2. **Feature Extraction**: LPC coefficients are extracted from the preprocessed audio signals, capturing the essential characteristics of each digit's pronunciation.

3. **Classification**: The KNN algorithm is implemented to classify the LPC-derived features, determining the most likely digit corresponding to each input sample.
