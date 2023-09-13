import QtQuick
import QtQuick.Controls.Material as QC2
import QtQuick.Layouts
import Felgo
import "../utils.js" as Utils

QC2.ComboBox {
    id: _comboBox
    model: ["First", "Second", "Third"]
    currentIndex: -1
    property string _promptText: "Enter prompt text"
    displayText: currentIndex === -1 ? _promptText : model[currentIndex]
    delegate: QC2.ItemDelegate {
        width: _comboBox.width
        contentItem: Text {
            text: _comboBox.textRole
                ? (Array.isArray(_comboBox.model) ? modelData[_comboBox.textRole] : model[_comboBox.textRole])
                : modelData
            color: currentIndex === index ? Utils.colors.deepBlue : Utils.colors.lightBlue
            font: _comboBox.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: _comboBox.highlightedIndex === index
    }

    indicator: Canvas {
        id: canvas
        x: _comboBox.width - width - _comboBox.rightPadding
        y: _comboBox.topPadding + (_comboBox.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"

        Connections {
            target: _comboBox
            function onPressedChanged() { canvas.requestPaint(); }
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = _comboBox.pressed ? "#17a81a" : Utils.colors.lightBlue;
            context.fill();
        }
    }

    contentItem: Text {
        leftPadding: 2
        rightPadding: _comboBox.indicator.width + _comboBox.spacing
        text: _comboBox.displayText
        font: _comboBox.font
        opacity: _comboBox.displayText === _comboBox._promptText ? 0.7 : 1.0
        color: Utils.colors.lightBlue
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: AppImage{
        source: "../../assets/custom_sqr_textfield.png"
    }

    popup: QC2.Popup {
        y: _comboBox.height - 1
        width: _comboBox.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: _comboBox.popup.visible ? _comboBox.delegateModel : null
            currentIndex: _comboBox.highlightedIndex

            QC2.ScrollIndicator.vertical: QC2.ScrollIndicator { }
        }

        background: AppImage{
            source: "../../assets/black_bg.png"
        }
    }
}

