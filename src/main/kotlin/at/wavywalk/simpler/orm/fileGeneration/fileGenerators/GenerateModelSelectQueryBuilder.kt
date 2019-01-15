package at.wavywalk.simpler.orm.fileGeneration.fileGenerators

import freemarker.template.Template
import at.wavywalk.simpler.orm.configs.templatingEngine.TemplateFilePathsConfig
import at.wavywalk.simpler.orm.fileGeneration.GeneratedFileFactory
import at.wavywalk.simpler.orm.fileGeneration.TemplateFactory
import at.wavywalk.simpler.orm.services.TemplateFileWriterService
import at.wavywalk.simpler.orm.templateDataModels.model.ModelDataModel
import java.io.File

class GenerateModelSelectQueryBuilder(val modelDataModel: ModelDataModel) {
    fun run(){
        val file: File = GeneratedFileFactory.createDefault(
                packageName = modelDataModel.packagesBean.baseGenerated,
                fileName = "${modelDataModel.modelClass}SelectQueryBuilder"
        )

        val templateName: String = TemplateFilePathsConfig.modelSelectQueryBuilder
        val template: Template = TemplateFactory.createTemplate(templateName)

        TemplateFileWriterService.writeTemplate(template, modelDataModel, file)
    }
}