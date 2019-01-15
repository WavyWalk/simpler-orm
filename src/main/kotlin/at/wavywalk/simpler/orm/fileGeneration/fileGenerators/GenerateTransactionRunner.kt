package at.wavywalk.simpler.orm.fileGeneration.fileGenerators

import freemarker.template.Template
import at.wavywalk.simpler.orm.fileGeneration.GeneratedFileFactory
import at.wavywalk.simpler.orm.fileGeneration.TemplateFactory
import at.wavywalk.simpler.orm.services.TemplateFileWriterService
import java.io.File

class GenerateTransactionRunner() {
    fun run(){
        val file: File = GeneratedFileFactory.createDefault(
                packageName = "orm.generated.utils",
                fileName = "TransactionRunner.kt"
        )

        val template: Template = TemplateFactory.createTemplate("transactionRunner.ftl")

        TemplateFileWriterService.writeTemplate(template, mutableMapOf<String,String>(), file)
    }
}