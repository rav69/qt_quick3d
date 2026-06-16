import QtQuick 2.15
import QtQuick3D 1.15

View3D {
    id: root

    property string modelName: ""
    property real modelScale: 1.0
    property vector3d cameraPosition: Qt.vector3d(0, 25, 150)
    property int rotationDuration: 8000

    environment: SceneEnvironment {
        backgroundMode: SceneEnvironment.Transparent
    }

    PerspectiveCamera {
        position: root.cameraPosition
    }

    DirectionalLight {
    }

    DynamicModel {
        id: model
        modelName: root.modelName
        scale: Qt.vector3d(root.modelScale, root.modelScale, root.modelScale)

        NumberAnimation on eulerRotation.y {
            from: 0
            to: 360
            duration: root.rotationDuration
            loops: Animation.Infinite
        }
    }



    // test cube
    Model {
        visible: false
        source: "#Cube"
        position: Qt.vector3d(0, 0, 0)
        scale: Qt.vector3d(.25, .25, .25)
        materials: DefaultMaterial {
            diffuseColor: "red"
            specularAmount: 0.5
        }
        NumberAnimation on eulerRotation.y {
            from: 0; to: 360; duration: 4000; loops: Animation.Infinite
        }
        NumberAnimation on eulerRotation.x {
            from: 0; to: 360; duration: 4000; loops: Animation.Infinite
        }
        NumberAnimation on eulerRotation.z {
            from: 0; to: 360; duration: 4000; loops: Animation.Infinite
        }
    }
}

///*
//        DirectionalLight {
//            id: keyLight
//            eulerRotation.x: -45
//            eulerRotation.y: 45
//            brightness: 100  // Увеличили с 100 до 200
//        }

//        // Заполняющий свет (убирает жёсткие тени)
//        DirectionalLight {
//            id: fillLight
//            eulerRotation.x: 30
//            eulerRotation.y: -135
//            brightness: 100
//            color: "#aaccff"  // Холодный оттенок для объёма
//        }
//*/
