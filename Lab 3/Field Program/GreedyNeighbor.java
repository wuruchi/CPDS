/* Homework: Safety & Progres (I)
 *
 *
 * Name: Carlos
 * Surname: Rojas Morales
 *
 * Name: Wilmer
 * Surname: Uruchi
 * 
 *
 */
package field;

public class GreedyNeighbor extends Thread {
    private final Flags flags;
    
    public GreedyNeighbor(Flags flags) {
    this.flags = flags;
    }
    
    public void run() {
        while (true) {
            try {
                String name = Thread.currentThread().getName();
                System.out.println("try again, my name is: "+ name);
                flags.set_true(name);
                //To model greedy write the sleep as follows
                Thread.sleep((int)(200*Math.random()));
                if ( !flags.query_flag(name) ) {
                    System.out.println(name + " enter");
                    Thread.sleep(400);
                    System.out.println(name + " exits");
                }
                Thread.sleep((int)(200*Math.random()));
                flags.set_false(name);
            }
            catch (InterruptedException e) {};
        } 
    }
    
}
