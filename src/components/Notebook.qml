import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import org.kde.kirigami 2.14 as Kirigami
import org.mauikit.controls 1.3 as Maui

import org.maui.kuill 1.0

import "."
Item
{
    id: control

    /**
    *
    */
    //property string squaresColor: "#FAEBD7"
    property string bgColor: "#FFFAF0"
    //property var squareSize: 15

    property var brushSize: 20
    property var brushOpacity: 1
    property var brushShape: 0 // 0 round, 1 rect
    property var maxBrushSize: 100
    property color paintColor: "blue"
    property real scale: 1

    property var pageWidth: 1
    property var pageHeight: 1

    Maui.ListBrowser
    {
        id: _list
        spacing: Maui.Style.space.big //+ control.pageHeight * control.scale
        anchors.fill: parent

        model: Maui.BaseModel
        {

            id: _model
            list: PagesList
            {
                id: _pages
            }
            sort: "n"
            sortOrder: Qt.AscendingOrder
        }

        delegate: _delegate
    }
    Component
    {
        id: _delegate
        Maui.ItemDelegate
        {
            hoverEnabled: false
            anchors.horizontalCenter: parent.horizontalCenter
            readonly property int index: _pages.count() - 1
            transformOrigin: Item.Top
            width: control.pageWidth * control.scale
            height: control.pageHeight * control.scale

            DrawCanvas
            {
                id: _canvas
                transformOrigin: Item.Top

                anchors.horizontalCenter: parent.horizontalCenter

                width: control.pageWidth
                height: control.pageHeight
                brushSize: control.brushSize + control.brushShape * (control.brushSize * 10) * (1 - control.brushOpacity) // scale the highliter brush to the correct size
                brushOpacity : control.brushOpacity
                brushShape: control.brushShape
                maxBrushSize: control.brushSize
                paintColor: control.paintColor
                scale: control.scale
                bgColor: control.bgColor

            }
            Component.onCompleted:
            {
                _pages.linkPage(_canvas.buffer)
            }
            
        }
    }
   

    Canvas
    {
        id: _out
        width: 1
        height: 1
        visible: false
    }

    function saveToFile(destination)
    {
        // drawing the background in the "output" file
        var count = _pages.count()
        console.log(count + " pages in saveToFile()")
        _out.width = pageWidth
        _out.height = pageHeight * count
        var ctx = _out.getContext("2d")
        for (var i = 0; i < count; i++){
            ctx.drawImage(_pages.getPage(i).getContext("2d").getImageData(0, 0, pageWidth, pageHeight), 0, pageHeight * i)
        }
        ctx.globalCompositeOperation = "destination-atop"
        ctx.fillStyle = bgColor
        ctx.fillRect(0, 0, pageWidth, pageHeight * count)
        _out.save(destination)
        ctx.clearRect(0, 0, pageWidth, pageHeight * count)
        _out.width = 1
        _out.height = 1
    }

    function addPage()
    {   
        _pages.add({"n" : _pages.count()})
    }

    function removePage()
    {
        _pages.remove(_pages.count() - 1)
    }
}
