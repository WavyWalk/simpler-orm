package at.wavywalk.simpler.orm.modelUtils

import java.sql.ResultSet

object RepositoryDbUtils {

    inline fun executeThisBlockAndCloseResultSet(resultSet: ResultSet, block: ()->Unit) {
        try {
            block.invoke()
        } finally {
            if (!resultSet.isClosed()) {
                resultSet.close()
            }
        }
    }

}