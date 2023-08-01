import os
from torch.utils.data import Dataset
from typing import List


class BinaryExeDataset (Dataset):
        def __init__ (self, file_dir = "./data", malicious_dir = False, training_dir = False):
            self.directory: str = file_dir
            self.is_malicious: bool = malicious_dir
            self.is_training: bool = training_dir
            self.file_list: List (str) = []
            for root, dirs, file in os.walk (self.directory):
                  self.file_list = file


        def __len__ (self):
             return len (self.file_list)

        
        def __getitem__ (self, idx = 0):
             # TODO: Set this up to return binary data of file at index, not just the name
             return (self.file_list[idx])
