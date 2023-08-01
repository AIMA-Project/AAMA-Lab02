from dataload import BinaryExeDataset

# Directories containing files for training and validating
DIR_MAL_TRAIN = "data/mal_train"
DIR_MAL_VALID = "data/mal_valid"
DIR_BEN_TRAIN = "data/ben_train"
DIR_BEN_VALID = "data/ben_valid"


if __name__ == "__main__":
    malicious_train    = BinaryExeDataset (DIR_MAL_TRAIN, True, True)
    malicious_validate = BinaryExeDataset (DIR_MAL_VALID, True, False)
    benign_train       = BinaryExeDataset (DIR_BEN_TRAIN, False, True)
    benign_validate    = BinaryExeDataset (DIR_BEN_VALID, False, False)
