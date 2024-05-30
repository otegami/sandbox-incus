sudo incus admin init --auto
sudo incus launch images:almalinux/8 target
max_retry=10
retry=0
until sudo incus exec target -- ping -c 1 google.com; do
  retry=$((retry + 1))
  echo "Attempt $retry of $max_retry"
  if [ $retry -ge $max_retry ]; then
    echo "Network is not ready after $max_retry attempts. Exiting."
    exit 1
  fi
  echo "Waiting for network to be ready... retrying in 1 second."
  sleep 1
done
echo "Network is ready. Performing system update."
sudo incus exec target -- sudo dnf update -y
sudo incus stop target
sudo incus delete target