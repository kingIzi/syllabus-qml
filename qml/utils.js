function h1() {
    return Qt.font({
                    pixelSize: sp(32),
                    bold: true,
                    letterSpacing: 4
                   })
}

function h2() {
    return Qt.font({
                    pixelSize: sp(24),
                    bold: true,
                    letterSpacing: 4
                   })
}

function h3() {
    return Qt.font({
                    pixelSize: sp(20),
                    bold: true,
                    letterSpacing: 4
                   })
}

function h4() {
    return Qt.font({
                       pixelSize: sp(18),
                       bold: true,
                       letterSpacing: 4
                   })
}

function h6() {
    return Qt.font({
                    pixelSize: sp(12),
                    letterSpacing: 1
                   })
}

function h5() {
    return Qt.font({
                    pixelSize: sp(16),
                    letterSpacing: 1
                   })
}


const colors = {
    "lightBlue": "#D6FFFF",
    "link": "#0090F8",
    "deepBlue": "#00fefe",
    "black": "#000000",
    "darkBlue": "#202A36",
    "darkGrey": "#6B6A6A",
    "brightRed": "#D07777"
};

function switchAppLoader(index){
    switch (index){
    case 0:
        _appLoader.sourceComponent = _homeComponent
        break;
    case 1:
        _appLoader.sourceComponent = _coursesComponent
        break;
    case 2:
        _appLoader.sourceComponent = _favoritesComponent
        break;
    default:
        _appLoader.sourceComponent = _regComponent
    }
}

function createSprite(filePath,parent,properties){
    let sprite = Qt.createComponent(filePath)
    return sprite.createObject(parent,properties)
}
