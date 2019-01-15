<#-- @ftlvariable name="" type="at.wavywalk.simpler.orm.templateDataModels.model.ModelDataModel" -->
<#-- @ftlvariable name="ab" type="at.wavywalk.simpler.orm.templateDataModels.model.AssociationBean" -->
package orm.utils

import at.wavywalk.simpler.orm.services.InTransactionJooqDslProvider
import at.wavywalk.simpler.orm.dependencymanagement.SimplerOrmDependenciesManager

object TransactionRunner {

    inline fun run(crossinline block: (InTransactionJooqDslProvider)->Unit){
        SimplerOrmDependenciesManager.provider.defaultDslContext.transaction { configuration ->
            block.invoke(
                    InTransactionJooqDslProvider(
                            configuration
                    )
            )
        }
    }

}