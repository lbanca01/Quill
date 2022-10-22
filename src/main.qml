import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import org.mauikit.controls 1.3 as Maui

import "./widgets"

Maui.ApplicationWindow
{
    id: root
    title: i18n("Quill")
    Maui.Style.styleType: Maui.Handy.isAndroid ? (settings.darkMode ? Maui.Style.Dark : Maui.Style.Light) : Maui.Sytle.Dark

    property font defaultFont : Qt.font({family: "Noto Sans Mono", pointSize: Maui.Style.fontSizes.huge})

    Settings
    {
        id: settings
        category: "General"
        property bool autoSync : true
        property bool autoSave: true
        property bool autoReload: true
        property bool lineNumbers: true

        property string sortBy:  "modified"
        property int sortOrder : Qt.DescendingOrder
        property bool darkMode : true

        property font font : defaultFont

        property bool spellcheckEnabled: true
    }

    Note
    {
        id: notesView
        anchors.fill: parent
        showCSDControls: true
    }

    Component.onCompleted:
    {
        setAndroidStatusBarColor()
    }

    function setAndroidStatusBarColor()
    {
        if(Maui.Handy.isAndroid)
        {
            Maui.Android.statusbarColor(Maui.Theme.backgroundColor, !settings.darkMode)
            Maui.Android.navBarColor(Maui.Theme.backgroundColor, !settings.darkMode)
        }
    }


}
