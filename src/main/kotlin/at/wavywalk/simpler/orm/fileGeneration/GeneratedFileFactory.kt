package at.wavywalk.simpler.orm.fileGeneration

import at.wavywalk.simpler.orm.fileGeneration.services.KotlinGeneratedDirPathAccessor
import java.io.File

object GeneratedFileFactory {

    fun createDefault(packageName: String, fileName: String): File {
        val completeFileName = "${fileName}.kt"
        val path = "${KotlinGeneratedDirPathAccessor.get()}/${packageName.split('.').joinToString("/")}"

        val directory = File(path)
        if (! directory.exists()){
            directory.mkdirs()
        }

        return File(
                path,
                completeFileName
        )
    }

}