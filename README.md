# rep1_julia

This repository contains replication files for Replication 1 using the Julia language with no additional packages beyond default.
Packages are listed and loaded in script during session.
That is, the Project.toml file is empty (see separate repository, 'rep1_julia_project' for repository with specified Project.toml). 
Either way, additional packages can be loaded 'on fly' during session, and doing so automatically updates Project.toml and generates Manifest.toml for reproducibility purposes.
Manifest is useful later because it specifies version of each package loaded into session. 
A new repository with these Project.toml and Manifest.toml files with reproduce exactly the same environment used here.

The files can be downloaded as one compressed folder using the drop-down menu in the green "Code" button above.

Also, a container (virtual machine) for remote replication online is available here: 

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/mattcingram/rep1_julia/HEAD)
