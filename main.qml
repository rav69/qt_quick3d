import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick3D 1.15
import "qrc:/"

//Window {
//    visible: true
//    width: 1024
//    height: 768

//    View3D {
//        anchors.fill: parent

//        PerspectiveCamera {
//            position: Qt.vector3d(0, 0, 500)
//        }

//        DirectionalLight {
//            position: Qt.vector3d(2, 3, 2)
//            brightness: 1.5
//        }

//        // Используем сгенерированный компонент
////        F_117 {  // Имя совпадает с именем вашего .obj файла
////            scale: Qt.vector3d(25, 25, 25)
//////            NumberAnimation on eulerRotation.x {
//////                from: 0; to: 360; duration: 8000; loops: Animation.Infinite
//////            }
////            NumberAnimation on eulerRotation.y {
////                from: 0; to: 360; duration: 8000; loops: Animation.Infinite
////            }
////        }
//    }
//}



//import QtQuick 2.15
//import QtQuick.Window 2.15
//import QtQuick3D 1.15

Window {
    id: window
    visible: true
    width: 800
    height: 600
    title: qsTr("Qt 5.15.2 GLB Model Loader")

    View3D {
        id: view3d
        anchors.fill: parent

        SceneEnvironment {
            id: env
            clearColor: "#222222"
            backgroundMode: SceneEnvironment.Color
        }
        environment: env

        PerspectiveCamera {
            id: camera
            z: 500
        }

        DirectionalLight {
            id: light
        }

                F_117 {  // Имя совпадает с именем вашего .obj файла
                    scale: Qt.vector3d(25, 25, 25)
        //            NumberAnimation on eulerRotation.x {
        //                from: 0; to: 360; duration: 8000; loops: Animation.Infinite
        //            }
                    NumberAnimation on eulerRotation.y {
                        from: 0; to: 360; duration: 8000; loops: Animation.Infinite
                    }
                }


//        Model {
//            id: loadedModel
//            source: "file:///home/user/build-Simple3DViewer_Qt5-Qt_5_15_2_gcc_64-Debug/model.glb"//"qrc:/model.glb"
//            scale: Qt.vector3d(1, 1, 1)
//            eulerRotation.y: 45
//        }
//        Model {
//            source: "#Cube"
//            position: Qt.vector3d(0, 0, 0)
//            scale: Qt.vector3d(1.5, 1.5, 1.5)
//            materials: DefaultMaterial {
//                diffuseColor: "red"
//                specularAmount: 0.5
//            }

//            NumberAnimation on eulerRotation.y {
//                from: 0; to: 360; duration: 4000; loops: Animation.Infinite
//            }
//            NumberAnimation on eulerRotation.x {
//                from: 0; to: 360; duration: 4000; loops: Animation.Infinite
//            }
//            NumberAnimation on eulerRotation.z {
//                from: 0; to: 360; duration: 4000; loops: Animation.Infinite
//            }
//        }
    }
}
