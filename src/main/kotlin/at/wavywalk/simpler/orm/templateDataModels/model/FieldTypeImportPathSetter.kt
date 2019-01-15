package at.wavywalk.simpler.orm.templateDataModels.model

object FieldTypeImportPathSetter {

    fun getPathToType(typeName: String): MutableList<String> {
        return when (typeName) {
            "Timestamp?", "Timestamp" -> mutableListOf<String>(
                    "java.sql.Timestamp",
                    "java.time.Instant"
            )
            else -> mutableListOf()

        }
    }

}