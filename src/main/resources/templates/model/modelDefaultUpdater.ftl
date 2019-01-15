<#-- @ftlvariable name="" type="at.wavywalk.simpler.orm.templateDataModels.model.ModelDataModel" -->
<#-- @ftlvariable name="ab" type="at.wavywalk.simpler.orm.templateDataModels.model.AssociationBean" -->
package ${packagesBean.baseGenerated}

import org.jooq.DSLContext
import ${packagesBean.jooqGeneratedTable}.*
import at.wavywalk.simpler.orm.modelUtils.RepositoryDbUtils
import ${packagesBean.model}
<#list packagesBean.fieldTypes as fieldType>
import ${fieldType}
</#list>
import at.wavywalk.simpler.orm.dependencymanagement.SimplerOrmDependenciesManager

object ${modelClass}DefaultUpdater {

    fun update(model: ${modelClass}, dslContext: DSLContext = SimplerOrmDependenciesManager.provider.defaultDslContext){

        <#if hasTimestamps>
        model.updatedAt = Timestamp(Instant.now().toEpochMilli())
        </#if>

        dslContext.update(${jooqTableInstance})
            <#list fieldBeansExceptPrimaryKey as fieldBean>
                .set(${jooqTableInstance}.${fieldBean.tableFieldName}, model.${fieldBean.property})
            </#list>
                .where(${jooqTableInstance}.${primaryKey.tableFieldName}.eq(model.${primaryKey.property}))
                .execute()
    }

}
