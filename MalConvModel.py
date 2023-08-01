'''

File derived from https://github.com/endgameinc/malware_evasion_competition/blob/master/models.py

'''

import torch
import numpy as np
from torch.nn import functional as funct
from MalConv import MalConv

class MalConvModel(object):
    def __init__(self, model_path, thresh=0.5, name='malconv'): 
        self.model = MalConv(channels=256, window_size=512, embd_size=8).train()
        weights = torch.load(model_path, map_location='cpu')
        self.model.load_state_dict(weights['model_state_dict'])
        self.thresh = thresh
        self.__name__ = name

    def predict(self, byte_buffer):
        _inp = torch.from_numpy(np.frombuffer(byte_buffer,dtype=np.uint8)[np.newaxis,:])
        with torch.no_grad():
            outputs = funct.softmax(self.model(_inp), dim=-1)

        return outputs.detach().numpy()[0,1] > self.thresh