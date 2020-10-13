# PyPI
Container stuff for the AWS hosted Python Package Index

---

## Info:

The packages live in a volume to keep them across container restarts

The pypi server itself is provided by devpi-server.

The upload API endpoint is protected by an htaccess file set within the nginx reverse-proxy.

The passwords are set in the arguments sections of the `docker-compose.yml` file.

More documentation available at: https://devpi.net/docs/devpi/devpi/stable/+d/index.html

---

## Uploading:

> Note:  The usernames, passwords, IPs, and ports given are just examples...

1. Create the builds:
    ```bash
    python3 setup.py sdist bdist_wheel
    ```

1. Copy all `.whl` and `.tar.gz` files into a directory `<ULOC>`.

1. ```bash
    pip3 install -U devpi-client
    devpi use https://pypi.tarrenj.com
    devpi login DevOps --password utest
    devpi use Dev
    devpi upload --from-dir <ULOC>
    
    devpi logout
    ```
