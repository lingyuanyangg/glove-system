// Optional argument: absolute path to an installed sharp package.
const path=require('path');const sharp=require(process.argv[2]||'sharp');
const folder=path.resolve(__dirname,'..');
sharp(path.join(folder,'ui-layout.svg')).resize(1968,338).png().toFile(path.join(folder,'ui-layout.png'));
