import torch
import cv2
import numpy as np

# Load MiDaS model
midas = torch.hub.load("intel-isl/MiDaS", "MiDaS_small")
midas_transforms = torch.hub.load("intel-isl/MiDaS", "transforms").small_transform

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
midas.to(device)
midas.eval()

def estimate_depth(image):
    # Preprocess the image and predict the depth map
    input_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    input_image = midas_transforms(input_image).to(device)

    with torch.no_grad():
        prediction = midas(input_image)

        # Resize prediction to original image size
        prediction = torch.nn.functional.interpolate(
            prediction.unsqueeze(1),
            size=image.shape[:2],
            mode="bicubic",
            align_corners=False,
        ).squeeze()

    depth_map = prediction.cpu().numpy()
    return depth_map
