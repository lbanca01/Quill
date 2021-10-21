import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import org.kde.kirigami 2.14 as Kirigami
import org.mauikit.controls 1.3 as Maui

import "."
Maui.Page
    {
        id: control

        background: Rectangle{
            width: _canvas.width
            height: _canvas.height
            color: bgColor
        }
        /**
        *
        */
        readonly property color bgColor : "#333"
        property alias brushSize : _canvas.brushSize
        property alias brushOpacity : _canvas.brushOpacity
        property alias brushShape : _canvas.brushShape //0 -Circular, 1 - rectangular.
        property alias maxBrushSize: _canvas.maxBrushSize
        property alias paintColor: _canvas.paintColor

        ScrollView
        {
            Layout.fillHeight: true
            Layout.fillWidth: true

            contentHeight: _canvas.height
            contentWidth: _canvas.width

            DrawCanvas
            {
                id: _canvas
                anchors.fill: parent
                width: 500
                height: 500
                brushSize: 50
                brushOpacity : 0.1
                brushShape: 1
                maxBrushSize: 500
                paintColor: "#00ff00"

            }

    }
}
