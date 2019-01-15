package at.wavywalk.simpler.orm.fileGeneration

import at.wavywalk.simpler.orm.templateDataModels.model.ModelDataModel

object AggregateModelsBank {

    val models: HashMap<String, ModelDataModel> = hashMapOf()

    fun registerModel(modelDataModel: ModelDataModel) {
        val valueAtKey = models[modelDataModel.modelClass]
        if (valueAtKey != null) {
            throw Throwable("model ${modelDataModel.modelClass}: already registered")
        }
        models[modelDataModel.modelClass] = modelDataModel
    }

}