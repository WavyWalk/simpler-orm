package at.wavywalk.simpler.orm.fileGeneration.fileGenerators

import freemarker.template.Template
import at.wavywalk.simpler.orm.configs.templatingEngine.TemplateFilePathsConfig
import at.wavywalk.simpler.orm.fileGeneration.GeneratedFileFactory
import at.wavywalk.simpler.orm.fileGeneration.TemplateFactory
import at.wavywalk.simpler.orm.services.TemplateFileWriterService
import at.wavywalk.simpler.orm.templateDataModels.model.ModelDataModel
import java.io.File

class GenerateModelInsertqueryBuilder(val modelDataModel: ModelDataModel) {
    fun run(){
        val file: File = GeneratedFileFactory.createDefault(
                packageName = modelDataModel.packagesBean.baseGenerated,
                fileName = "${modelDataModel.modelClass}InsertQueryBuilder.kt"
        )

        val templateName: String = TemplateFilePathsConfig.modelInsertQueryBuilder
        val template: Template = TemplateFactory.createTemplate(templateName)

        TemplateFileWriterService.writeTemplate(template, modelDataModel, file)
    }
}