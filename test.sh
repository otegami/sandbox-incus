sudo incus admin init --auto
sudo incus launch images:almalinux/8 target
until sudo incus exec target -- sudo systemctl is-system-running --wait; do
  sleep 1
done
sudo incus exec target -- sudo dnf update -y
sudo incus stop target
sudo incus delete target
