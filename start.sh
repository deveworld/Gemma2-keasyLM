export USER=$(whoami)
export TPU_NAME='v4-64'
export ZONE='us-central2-b'

echo "[local] Killing TPU"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME \
--zone $ZONE --worker=all --command "sudo fuser -k /dev/accel0"

echo "[local] Removing TPU Lock"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME \
--zone $ZONE --worker=all --command "sudo rm -f /tmp/libtpu_lockfile"

echo "[local] Killing All Python"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME \
--zone $ZONE --worker=all --command "pkill -e python"

echo "[local] Removing screens"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME \
--zone $ZONE --worker=all --command "killall screen"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME \
--zone $ZONE --worker=all --command "rm screenlog*"

echo "[local] Git pull"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME --zone $ZONE --worker=all --command \
" sudo apt install -y git wget ; git clone https://github.com/deveworld/Gemma2-keasyLM/ ;\
cd ~/Gemma2-keasyLM/ && git pull"

echo "[local] Prepare Env"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME --zone $ZONE --worker=all --command \
"cd ~/Gemma2-keasyLM; bash prepare_env.sh; "
