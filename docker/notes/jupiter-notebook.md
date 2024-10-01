# Starting jupiter notebook

login to supermicro host then:
```
$docker_start_jupiter.sh
$docker_list.sh
>>>>>>>>>Docker container list<<<<<<<<<<
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS          PORTS                                                                                      NAMES
444ed3755ad7   continuumio/anaconda3   "/bin/bash -c '    c…"   20 minutes ago   Up 19 minutes   0.0.0.0:8888->8888/tcp, :::8888->8888/tcp

# Next get the tocken from docker container logs 
$sudo docker logs 444ed3755ad7

[W 2024-05-20 23:09:44.474 LabApp] 'allow_root' has moved from NotebookApp to ServerApp. This config will be passed to ServerApp. Be sure to update your config before our next release.
[I 2024-05-20 23:09:44.480 LabApp] JupyterLab extension loaded from /opt/conda/lib/python3.10/site-packages/jupyterlab
[I 2024-05-20 23:09:44.480 LabApp] JupyterLab application directory is /opt/conda/share/jupyter/lab
[I 23:09:49.366 NotebookApp] Serving notebooks from local directory: /opt/notebooks
[I 23:09:49.366 NotebookApp] Jupyter Notebook 6.5.2 is running at:
[I 23:09:49.366 NotebookApp] http://444ed3755ad7:8888/?token=a3cd53dd413be34e906c8a98ca7af88c3439194946acd4a2
[I 23:09:49.366 NotebookApp]  or http://127.0.0.1:8888/?token=a3cd53dd413be34e906c8a98ca7af88c3439194946acd4a2
[I 23:09:49.366 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 23:09:49.378 NotebookApp]

    To access the notebook, open this file in a browser:
        file:///root/.local/share/jupyter/runtime/nbserver-1-open.html
    Or copy and paste one of these URLs:
        http://444ed3755ad7:8888/?token=a3cd53dd413be34e906c8a98ca7af88c3439194946acd4a2    <<<<<HERE>>>>>
     or http://127.0.0.1:8888/?token=a3cd53dd413be34e906c8a98ca7af88c3439194946acd4a2
[I 23:13:03.032 NotebookApp] 302 GET / (192.168.12.226) 6.960000ms
```

# running on the web browser
 go to: http://supermicro:8888
- You may be asked for the token and then create a new password. Then
- you will be directed to the home page.

# Installing RUST on jupiter notebook 

https://datacrayon.com/data-analysis-with-rust-notebooks/setup-anaconda-jupyter-and-rust/#install-rust
https://koushik-dutta.medium.com/install-jupyter-notebook-kernels-for-java-scala-go-rust-r-8272f7c75d45

```
$ conda install -y -c conda-forge nb_conda_kernels
$ cargo install evcxr_jupyter
$ evcxr_jupyter --install
$ jupyter notebook
```

