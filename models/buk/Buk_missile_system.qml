import QtQuick 2.15
import QtQuick3D 1.15

Node {
    id: sketchfab_model
    eulerRotation.x: -90

    Node {
        id: buk_tex_obj_cleaner_materialmerger_gles

        Model {
            id: object_2
            source: "meshes/object_2.mesh"

            PrincipledMaterial {
                id: scene___Root_material
                baseColorMap: Texture {
                    source: "maps/0.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalnessMap: Texture {
                    source: "maps/1.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                metalnessChannel: Material.B
                roughnessMap: Texture {
                    source: "maps/1.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                roughnessChannel: Material.G
                roughness: 0.117715
                normalMap: Texture {
                    source: "maps/2.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionMap: Texture {
                    source: "maps/1.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                occlusionChannel: Material.R
                cullMode: Material.NoCulling
            }
            materials: [
                scene___Root_material
            ]
        }

        Model {
            id: object_3
            source: "meshes/object_3.mesh"
            materials: [
                scene___Root_material
            ]
        }

        Model {
            id: object_4
            source: "meshes/object_4.mesh"
            materials: [
                scene___Root_material
            ]
        }

        Model {
            id: object_5
            source: "meshes/object_5.mesh"
            materials: [
                scene___Root_material
            ]
        }

        Model {
            id: object_6
            source: "meshes/object_6.mesh"
            materials: [
                scene___Root_material
            ]
        }

        Model {
            id: object_7
            source: "meshes/object_7.mesh"
            materials: [
                scene___Root_material
            ]
        }

        Model {
            id: object_8
            source: "meshes/object_8.mesh"
            materials: [
                scene___Root_material
            ]
        }
    }
}
