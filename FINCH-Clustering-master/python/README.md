
##### Python Requirements

See requirements.txt

[Optional]: Install [pyflann](https://github.com/nashory/pyflann) to get first neighbours from Kd-tree for large data


## Usage:
Run from command line by providing path to csv data files
``` 
python3 finch.py --data-path [Your-path-to-data-csv] --output-path [path-to-write-the result]
```
or typically you would run: 
``` 
from finch import FINCH
c, num_clust, req_c = FINCH(data)

```
You can set options e.g., required number of cluster [optional] or distance etc,

```
c, num_clust, req_c = FINCH(data, initial_rank=None, req_clust=None, distance='cosine', verbose=True)
```

Input:

* data: numpy array (feature vectors in rows)
* initial_rank [Optional]: Nx1 vector of 1-neighbour indices.
* verbos : for printing some output

Output:

* c: N x P array,  each column vector contains cluster labels for each partition P
* num_clust: shows total number of cluster in each partition P
* req_c: Labels of required clusters (Nx1). Only set if `req_clust` is not None.

