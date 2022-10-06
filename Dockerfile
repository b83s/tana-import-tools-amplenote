FROM okteto/node:16

RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates curl
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubelet kubeadm kubectl
RUN apt-mark hold kubelet kubeadm kubectl

RUN npm install --global --force yarn

# setup okteto message
COPY bashrc /root/.bashrc

WORKDIR /usr/src/app

ADD package.json .
RUN npm install


EXPOSE 3000

CMD npm start