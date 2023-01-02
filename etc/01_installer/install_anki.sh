# NAME:   anki.sh
# AUTHOR: marsh
#
# NOTE:   Install anki
#

## CONFIG:
# ANKI_URL="https://github.com/ankitects/anki/releases/download/2.1.53/anki-2.1.53-linux-qt5.tar.zst"
ANKI_URL="https://github.com/ankitects/anki/releases/download/2.1.53/anki-2.1.53-linux-qt6.tar.zst"
COMP_NAME="${ANKI_URL##*/}"
FOLDER="${COMP_NAME%.tar*}"


## SCIPT:
mkdir tmp && cd tmp

echo "Downloading from ${ANKI_URL}..."
wget ${ANKI_URL}
tar xaf ${COMP_NAME}


echo "Installing anki"
cd ${FOLDER}
sudo ./install.sh


echo "Clear env..."
cd ../../
rm -Rf ./tmp
