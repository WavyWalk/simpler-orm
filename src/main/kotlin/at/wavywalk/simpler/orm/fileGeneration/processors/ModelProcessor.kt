package at.wavywalk.simpler.orm.fileGeneration.processors

import at.wavywalk.simpler.orm.annotations.IsModel
import at.wavywalk.simpler.orm.configs.templatingEngine.TemplatingEngineConfig
import at.wavywalk.simpler.orm.fileGeneration.AggregateModelsBank
import at.wavywalk.simpler.orm.fileGeneration.ProcessorContext
import at.wavywalk.simpler.orm.fileGeneration.services.KotlinGeneratedDirPathAccessor
import at.wavywalk.simpler.orm.fileGeneration.fileGenerators.GenerateModelFiles
import at.wavywalk.simpler.orm.fileGeneration.fileGenerators.GenerateTransactionRunner
import at.wavywalk.simpler.orm.templateDataModels.model.AssociationBeansFactory
import at.wavywalk.simpler.orm.templateDataModels.model.ModelDataModelFactory
import javax.annotation.processing.*
import javax.lang.model.SourceVersion
import javax.lang.model.element.Element
import javax.lang.model.element.TypeElement

@SupportedSourceVersion(SourceVersion.RELEASE_8)
class ModelProcessor : AbstractProcessor() {

    override fun getSupportedAnnotationTypes(): Set<String> {
        return setOf(
                "at.wavywalk.simpler.orm.annotations.IsModel"
        )
    }

    override fun init(processingEnv: ProcessingEnvironment?) {
        runTemplateEngineConfigIfNotRunAlready()
        ProcessorContext.setProcessingEnvironment(processingEnv!!)
        super.init(processingEnv)
    }

    private fun runTemplateEngineConfigIfNotRunAlready() {
        TemplatingEngineConfig.runIfNotRunAlready()
    }

    override fun process(
            annotations: MutableSet<out TypeElement>,
            roundEnv: RoundEnvironment
    ): Boolean {

        val annotatedElements: MutableSet<out Element> = roundEnv.getElementsAnnotatedWith(IsModel::class.java)
        if (annotatedElements.isEmpty()) {
            return false
        }
        KotlinGeneratedDirPathAccessor.setByExtractingFrom(this.processingEnv)

        ProcessorContext.setRoundEnvironment(roundEnv)

        GenerateTransactionRunner().run()
        //associations are not build here, because they require that all models are generated first
        //each model there will be added to AggregateModelsBank
        ModelDataModelFactory.createAllAndAddToModelsBank(annotatedElements, processingEnv.elementUtils)
        //will use models from AggregateModelsBank that are build upper
        AssociationBeansFactory.createAll(AggregateModelsBank.models.values)

        GenerateModelFiles.generate(AggregateModelsBank.models.values)

        return true
    }




}