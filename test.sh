sudo incus admin init --auto
sudo incus launch images:almalinux/8 target
max_retry=3
retry=0
until sudo incus exec target -- sudo dnf update -y; do
  retry=$((retry + 1))
  echo "Attempt $retry of $max_retry"
  if [ $retry -ge $max_retry ]; then
    echo "Network is not ready after $max_retry attempts. Exiting."
    exit 1
  fi
  echo "Waiting for network to be ready... retrying in 3 second."
  sleep 3
done
sudo incus stop target
sudo incus delete target
