<#-- @ftlvariable name="" type="at.wavywalk.simpler.orm.templateDataModels.model.ModelDataModel" -->
<#-- @ftlvariable name="ab" type="at.wavywalk.simpler.orm.templateDataModels.model.AssociationBean" -->
package ${packagesBean.baseGenerated}

import at.wavywalk.simpler.orm.services.ModelInvalidError
import org.jooq.SelectQuery
import org.jooq.Condition
import org.jooq.DSLContext
import org.jooq.TableLike
import org.jooq.SelectField
import java.sql.ResultSet
import ${packagesBean.jooqGeneratedTable}.*
import ${packagesBean.jooqGeneratedTable}
import ${packagesBean.jooqTablesRoot}.records.${jooqRecordClass}
import ${packagesBean.model}
<#list packagesBean.fieldTypes as fieldType>
import ${fieldType}
</#list>
<#list packagesBean.associatedModelTypesToImport as typeToImport>
import ${typeToImport}
</#list>
import at.wavywalk.simpler.orm.dependencymanagement.SimplerOrmDependenciesManager
import at.wavywalk.simpler.orm.dependencymanagement.adapterinterfaces.IArrayNode
import at.wavywalk.simpler.orm.dependencymanagement.adapterinterfaces.IObjectNode

class ${modelClass}ToJsonSerializer(val model: ${modelClass}) {
    companion object {
        val objectMapper = SimplerOrmDependenciesManager.provider.jsonObjectMapper
    
        fun serialize(models: MutableList<${modelClass}>): IArrayNode {
            val root = objectMapper.createArrayNode()
            models.forEach {
                root.add(${modelClass}ToJsonSerializer(it).serializeToNode())
            }
            return root
        }

        inline fun serialize(models: MutableList<${modelClass}>, block: (${modelClass}ToJsonSerializer)->Unit): IArrayNode {
            val root = objectMapper.createArrayNode()
            models.forEach {
                val serializer = ${modelClass}ToJsonSerializer(it)
                block.invoke(serializer)
                root.add(serializer.serializeToNode())
            }
            return root
        }

    }

    class WhichPropertiesToSerialize {
    <#list fieldBeans as fieldBean>
        var ${fieldBean.property} = true
    </#list>
    }

    val whichPropertiesToSerialize = WhichPropertiesToSerialize()

    val root = objectMapper.createObjectNode()

    fun includeErrors(): ${modelClass}ToJsonSerializer {
        val node = objectMapper.createObjectNode()
        model.record.validationManager.nonNullableErrors().forEach {
            key, value ->
            val arrayNode = objectMapper.createArrayNode()
            value.forEach {
                arrayNode.add(it)
            }
            node.set(key, arrayNode)
        }
        root.set("errors", node)
        return this
    }


    <#list associationBeans as ab>

    <#if ab.associationType == "HAS_ONE" || ab.associationType == "BELONGS_TO" || ab.associationType == "HAS_ONE_AS_POLYMORPHIC">
    fun include${ab.capitalizedPropertyName}(): ${modelClass}ToJsonSerializer {
        model.${ab.propertyName}?.let {
            root.set("${ab.propertyName}", ${ab.associatedModelDataModel.modelClass}ToJsonSerializer(it).serializeToNode())
            return this
        }
        root.set("${ab.propertyName}", null)
        return this
    }

    inline fun include${ab.capitalizedPropertyName}(block: (${ab.associatedModelDataModel.modelClass}ToJsonSerializer)->Unit): ${modelClass}ToJsonSerializer {
        model.${ab.propertyName}?.let {
            val thatModelSerializer = ${ab.associatedModelDataModel.modelClass}ToJsonSerializer(it)
            block.invoke(thatModelSerializer)
            root.set("${ab.propertyName}", thatModelSerializer.serializeToNode())
            return this
        }
        root.set("${ab.propertyName}", null)
        return this
    }
    </#if>
    <#if ab.associationType == "BELONGS_TO_POLYMORPHIC">
    fun include${ab.capitalizedPropertyName}(): ${modelClass}ToJsonSerializer {
        model.${ab.propertyName}?.let {
            when(it) {
                <#list ab.associatedPolymorphicModelDataModels as associatedModelDataModel>
                is ${associatedModelDataModel.modelClass} -> {
                    root.set("${ab.propertyName}", ${associatedModelDataModel.modelClass}ToJsonSerializer(it).serializeToNode())
                    return this
                }
                </#list>
                else -> {
                    root.set("${ab.propertyName}", null)
                    return this
                }
            }
        }
        root.set("${ab.propertyName}", null)
        return this
    }

    class ${ab.capitalizedPropertyName}PolymorphicIncludeYielderProxy() {
        <#list ab.associatedPolymorphicModelDataModels as associatedModelDataModel>
        var ${associatedModelDataModel.modelClassDecapitalized}: ${associatedModelDataModel.modelClass}ToJsonSerializer? = null
        </#list>
    }

    inline fun include${ab.capitalizedPropertyName}(block: (${ab.capitalizedPropertyName}PolymorphicIncludeYielderProxy)->Unit): ${modelClass}ToJsonSerializer {
        model.${ab.propertyName}?.let {
            when(it) {
                <#list ab.associatedPolymorphicModelDataModels as associatedModelDataModel>
                is ${associatedModelDataModel.modelClass} -> {
                    val proxyYielder = ${ab.capitalizedPropertyName}PolymorphicIncludeYielderProxy()
                    val thatModelSerializer = ${associatedModelDataModel.modelClass}ToJsonSerializer(it)
                    proxyYielder.${associatedModelDataModel.modelClassDecapitalized} = thatModelSerializer
                    block.invoke(proxyYielder)
                    root.set("${ab.propertyName}", thatModelSerializer.serializeToNode())
                    return this
                }
                </#list>
                else -> {
                    root.set("${ab.propertyName}", null)
                    return this
                }
            }
        }
        root.set("${ab.propertyName}", null)
        return this
    }
    </#if>
    <#if ab.associationType == "HAS_MANY" || ab.associationType == "HAS_MANY_AS_POLYMORPHIC">
    fun include${ab.capitalizedPropertyName}(): ${modelClass}ToJsonSerializer {
        model.${ab.propertyName}?.let {
            val arrayNode = objectMapper.createArrayNode()
            it.forEach { thatModel ->
                arrayNode.add(${ab.associatedModelDataModel.modelClass}ToJsonSerializer(thatModel).serializeToNode())
            }
            root.set("${ab.propertyName}", arrayNode)
            return this
        }
        root.set("${ab.propertyName}", null)
        return this
    }

    inline fun include${ab.capitalizedPropertyName}(block: (${ab.associatedModelDataModel.modelClass}ToJsonSerializer)->Unit): ${modelClass}ToJsonSerializer {
        model.${ab.propertyName}?.let {
            val arrayNode = objectMapper.createArrayNode()
            it.forEach { thatModel ->
                val thatModelSerializer = ${ab.associatedModelDataModel.modelClass}ToJsonSerializer(thatModel)
                block.invoke(thatModelSerializer)
                arrayNode.add(thatModelSerializer.serializeToNode())
            }
            root.set("${ab.propertyName}", arrayNode)
            return this
        }
        root.set("${ab.propertyName}", null)
        return this
    }
    </#if>
    </#list>

    fun setApplicablePropertiesToNode(){
        whichPropertiesToSerialize.let {
            <#list fieldBeans as fieldBean>
            if (it.${fieldBean.property}) {
                <#if fieldBean.property == "createdAt" || fieldBean.property == "updatedAt" || fieldBean.nonNullableType == "Timestamp">
                root.set("${fieldBean.property}", model.${fieldBean.property}?.toString())
                <#else>
                root.set("${fieldBean.property}", model.${fieldBean.property})
                </#if>
            }
            </#list>
        }
    }

    fun serializeToNode(): IObjectNode{
        setApplicablePropertiesToNode()
        return root
    }

    fun serializeToString(): String {
        setApplicablePropertiesToNode()
        return root.toString()
    }

    fun set(key: String, value: String?) {
        root.set(key, value)
    }

    fun set(key: String, value: Int?) {
        root.set(key, value)
    }

    fun set(key: String, value: Long?) {
        root.set(key, value)
    }

    fun set(key: String, value: Boolean) {
        root.set(key, value)
    }

    fun set(key: String, value: IArrayNode) {
        root.set(key, value)
    }

}
