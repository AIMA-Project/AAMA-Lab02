'''

MalConv.py
https://github.com/endgameinc/malware_evasion_competition/blob/master/MalConv.py

'''

from torch import transpose, sigmoid
from torch import nn as neural_net
from torch.nn import functional as funct

class MalConv(neural_net.Module):
    # trained to minimize cross-entropy loss
    # criterion = nn.CrossEntropyLoss()
    def __init__(self, out_size=2, channels=128, window_size=512, embd_size=8):
        super(MalConv, self).__init__()
        self.embd = neural_net.Embedding(257, embd_size, padding_idx=0)
        
        self.window_size = window_size
    
        self.conv_1 = neural_net.Conv1d(embd_size, channels, window_size, stride=window_size, bias=True)
        self.conv_2 = neural_net.Conv1d(embd_size, channels, window_size, stride=window_size, bias=True)
        
        self.pooling = neural_net.AdaptiveMaxPool1d(1)
        
        self.fc_1 = neural_net.Linear(channels, channels)
        self.fc_2 = neural_net.Linear(channels, out_size)


    def forward(self, x):
        
        x = self.embd(x.long())
        x = transpose(x,-1,-2)
        
        cnn_value = self.conv_1(x)
        gating_weight = sigmoid(self.conv_2(x))
        
        x = cnn_value * gating_weight
        
        x = self.pooling(x)
        
        #Flatten
        x = x.view(x.size(0), -1)
        
        x = funct.relu(self.fc_1(x))
        x = self.fc_2(x)
        
        return x