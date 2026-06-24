import QtQuick 2.15
import QtQuick3D 1.15

Node {
    id: sketchfab_model
    eulerRotation.x: -90

    Node {
        id: b6c56490191b4de489f1d583b4c58164_fbx
        eulerRotation.x: 90
        scale.x: 0.01
        scale.y: 0.01
        scale.z: 0.01

        Node {
            id: rootNode

            Node {
                id: bayraktar_tb2
                eulerRotation.x: -90
                scale.x: 100
                scale.y: 100
                scale.z: 100

                Model {
                    id: bayraktar_tb2_mat_bay_tb2_0
                    source: "meshes/bayraktar_tb2_mat_bay_tb2_0.mesh"

                    PrincipledMaterial {
                        id: mat_bay_tb2_material
                        baseColorMap: Texture {
                            source: "maps/0.png"
                            tilingModeHorizontal: Texture.Repeat
                            tilingModeVertical: Texture.Repeat
                        }
                        opacityChannel: Material.A
                        metalness: 0
                        roughness: 0.773726
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        mat_bay_tb2_material
                    ]
                }
            }
        }
    }
}
