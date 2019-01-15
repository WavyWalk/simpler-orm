package at.wavywalk.simpler.orm.fileGeneration

import at.wavywalk.simpler.orm.configs.templatingEngine.TemplatingEngineConfig
import freemarker.template.Template

object TemplateFactory {

    fun createTemplate(templateName: String): Template {
        try {
            return TemplatingEngineConfig.templateEngineConfiguration.getTemplate(
                    templateName
            )
        } catch (error: Exception) {
            throw error
        }
    }

}